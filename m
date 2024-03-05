Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D4AC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F8D88046;
	Tue,  5 Mar 2024 11:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634783;
	bh=6tDZulcyjDq67Oc+qvgr9K96lk/o8XSk6KYCtcfnX7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVPed7MOWpPzVPQRM6lMnaGh5C6h7JTpGeE61pDXP+gLk62sIOvD7NWkeh1hao/Sl
	 xIswhSSXuYUzDAY14O6xd3KGjowBwk0lTgD2OS2xSxMy4K1iFEkrgP49WuQlWTzH3C
	 c5bAKXcUTkXpMUAFFmI6PNdaEQ6s+VzK7EfuaireRbwH6AuQpUOfQmsKVAJojWWmqB
	 Mn+L8RYF7f2SOWQnVj7wXl4DGhNVqJbt6C8wbcfVnUf9cvHi9MDvV7JiU+Xb2hLE8O
	 PCDHcHuNMX90asY8e9NM/cPXvNIRJNREdC20znUpHXNgB/TeRvqdd3FEGITQ7kjwzJ
	 lR3Ew7kZkiltQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6C188042; Tue,  5 Mar 2024 11:33:01 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE1888023
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4TpsMs1LSMz9sbY;
 Tue,  5 Mar 2024 11:32:57 +0100 (CET)
Message-ID: <06986d4a-5ed9-4986-8356-84369b257543@denx.de>
Date: Tue, 5 Mar 2024 11:32:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] board: helios-4: add config fragment for spi
 booting
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Dennis Gilmore <dgilmore@redhat.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240202-helios4-spi-v2-0-df085461d894@solid-run.com>
 <20240202-helios4-spi-v2-3-df085461d894@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240202-helios4-spi-v2-3-df085461d894@solid-run.com>
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

On 2/2/24 16:13, Josua Mayer wrote:
> Add a config fragment with required differences for booting from spi
> flash instead of sd-card (default).
> 
> Settings for environment location are based on vendor u-boot:
> https://github.com/kobol-io/u-boot/blob/helios4/include/configs/helios4.h#L59
> 
> The fragment can be applied on top of helios4_defconfig by make:
> make helios4_defconfig spiboot.config
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   board/kobol/helios4/spiboot.config | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/board/kobol/helios4/spiboot.config b/board/kobol/helios4/spiboot.config
> new file mode 100644
> index 0000000000..5ffb7d2e3b
> --- /dev/null
> +++ b/board/kobol/helios4/spiboot.config
> @@ -0,0 +1,4 @@
> +CONFIG_MVEBU_SPL_BOOT_DEVICE_SPI=y
> +# CONFIG_MVEBU_SPL_BOOT_DEVICE_MMC is not set
> +CONFIG_ENV_OFFSET=0x100000
> +CONFIG_ENV_SECT_SIZE=0x10000
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
