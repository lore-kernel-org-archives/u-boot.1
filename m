Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D12C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 16:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 744F887EED;
	Sun, 17 Mar 2024 17:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710692562;
	bh=3TomrzdcdmeYTaglX1DAxVZInBhddB6lYdoP7p2pjOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mrkUoL+DB3sWu2/liwr5PKUvVUZUv26fgOmKtOGfaKCgfPJCC2/CyFTWyfptsnkMu
	 +hBo2i7PmbpfzcmuxXGuRFVpzQ+jX296x+zAn0jecri2kivVUEuLV2FyPfoeqE1zX3
	 FenJiPz0vzbNnBxFvzHn2/SCO100DmUnmpOvp9dFjtbYXw/TNK1naoyhzeRiN3S5CG
	 A2X5l+kCHdB/ds5s8hb74LHs4BN5Por2at9flTCKP/aPB+Jlf14cnxoVz7bbzDq1Qa
	 /azr5R7iaHj82ggECYRyhj9fzL2UdEPEdit1dSWRrKdd+EQTGqCUxeCk9FGmHxjA7I
	 p5YNCveggo/GQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A17D587A00;
 Sun, 17 Mar 2024 17:22:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710692561;
 bh=3TomrzdcdmeYTaglX1DAxVZInBhddB6lYdoP7p2pjOE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m3qNzo0IZNuHjm6n1TGcNP3/coxg5fMXOrjx21Pg2ckGQHMYmnQLq7OvfTp2E8NEY
 SA+CvN4IWI8ymPzh+oTkBtqBDL2GZ/3OFBvmIyzrTUHmoI3j91HY0NGx+rDqRefrU7
 zM9pkhZrm+oo9UmF35Azt2mmCKFlL1qqhnWWzWk9RMzN9SkH+34hLES1U9zlQh1hJB
 PkXGdUs9QjmHxBOlCymc3KRc4BRII32S1+FkMbfhTtm6+u2gSoKCuSyr4UU7rd9Ha1
 w8yu1Gkc5F+qTjNRHBbC+/mI0a0Uw8VWxxrmnbbszNKH4hEEH1dxWja00I8GiHAnA+
 IKkHBifIMTHmg==
Message-ID: <22be2258-ff20-4e62-a169-4748cbba4904@denx.de>
Date: Sun, 17 Mar 2024 17:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Language: en-US
To: j@jannau.net, Bin Meng <bmeng.cn@gmail.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/17/24 12:07 PM, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
> 
> Add the environment variable "usb_blocklist" to prevent USB devices
> listed in it from being used. This allows to ignore devices which
> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
> Devices emulating keyboards are one example. U-boot currently supports
> only one USB keyboard device. Most commonly, people run into this with
> Yubikeys, so let's ignore those in the default environment.
> 
> Based on previous USB keyboard specific patches for the same purpose.
> 
> Link: https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   common/usb.c              | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>   doc/usage/environment.rst | 12 ++++++++++
>   include/env_default.h     | 11 ++++++++++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9..73af5be066 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device *dev, int addr, bool do_read,
>   	return 0;
>   }
>   
> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
> +{
> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
> +	       blocklist);
> +	return 0;

This could be static void without return 0 at the end.

> +}
> +
> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
> +{
> +	ulong vid, pid;
> +	char *end;
> +	const char *block_str = env_get("usb_blocklist");
> +	const char *cur = block_str;
> +
> +	/* parse "usb_blocklist" strictly */
> +	while (cur && cur[0] != '\0') {

Have a look at strsep() , namely strsep(block_str, ","); This will split 
the string up for you at "," delimiters.

Example is in drivers/dfu/dfu.c dfu_config_interfaces() .

And then, on each token, you can try and run sscanf(token, "%04x:%04x", 
vid, pid);, that will parse the token format for you. See e.g. 
test/lib/sscanf.c for further examples.

That should simplify the parsing a lot.

[...]
