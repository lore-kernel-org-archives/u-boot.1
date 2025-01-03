Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5E8E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 09:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BFB8034E;
	Fri,  3 Jan 2025 10:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="H6xXCsgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25BE8034E; Fri,  3 Jan 2025 10:25:42 +0100 (CET)
Received: from mail-m49251.qiye.163.com (mail-m49251.qiye.163.com
 [45.254.49.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024C9801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 10:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 79d1fae2;
 Fri, 3 Jan 2025 17:25:33 +0800 (GMT+08:00)
Message-ID: <9704f6fb-25e6-4781-ab0a-eadb8a182b2c@rock-chips.com>
Date: Fri, 3 Jan 2025 17:25:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241212235735.164272-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkhDVkoYQxodHklNQhgfS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a942b7bfd0503afkunm79d1fae2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6Fww6ATIKEywaHTVIDwk9
 TQIKFDlVSlVKTEhOQ0JNSEhOS0tOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpLSU43Bg++
DKIM-Signature: a=rsa-sha256;
 b=H6xXCsgrDSHAGL/+qkoqRdghEW2ib014FajpP85rN8f/2JPT25nhcNFWbrlIH2uCP65RhJUgI2WN1Ow0JG3wh+Hof2nl7Joe/eHqktF+yd7gmu6n83IcnLJe0gX3N4kxsyfAyZkPXyGtXsFp6EABZnd86JJ+nFDuFccVzg0h0v0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=6JBTHbze5XOJwt7BGo0sq23wlCPxhbq87bsI+v7TSXA=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
> by binman for the u-boot-rockchip.bin image.
>
> Change to include the binman generated FIT for the u-boot.rom image.
>
> This change result in TF-A being included and the use sha256 instead of
> crc32 checksum in the u-boot.rom FIT.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-u-boot.dtsi | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index bd7527dde223..70f35b6c197a 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -50,7 +50,9 @@
>   			u-boot-spl {
>   			};
>   		};
> -		u-boot-img {
> +		fit {
> +			type = "blob";
> +			filename = "u-boot.itb";
>   			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>   		};
>   		u-boot {
