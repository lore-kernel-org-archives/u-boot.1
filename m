Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219C6E9370D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C561E86CC5;
	Thu,  5 Oct 2023 15:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696510916;
	bh=gPPHHh7HoJkYn0J0AX5Oj30xrPVMYFY180ovmiMpBoo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eATc01U6KR186rsBCaRcYICCTb0662ylM/53Gi2z9nsnoYAFYgIuAYCy/WVVSPaGQ
	 dbpz/85ej/GKyg/p3gqawPS52vskFAOe6wQlJcLtmXcZXRvChpte1hRiY7woFwDG+J
	 nzsXAl/ZoiKjtRmjAgg8fh8NADNvlhG/xW/UWXWROhv3gZhN0yZATsUzFwuSn05lak
	 ps9IShwQOw3juQXYo9nl0NiR60n4xovfczPeVPC5/wfm3pIJJA0iY4qzIz3NHnWbtc
	 5KwrHNCh0BMLEAZzAgCrM4zqLbqdubcqcszw6Y5cfJ6d7OPYbe2iKuf55GdxJsel17
	 XdXpoRIhxfWsg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36D5386CBB;
 Thu,  5 Oct 2023 15:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696510912;
 bh=gPPHHh7HoJkYn0J0AX5Oj30xrPVMYFY180ovmiMpBoo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SZl1d44ts6mAk8mYnuSnYwGzygsK+jvG9H3++JcHQON3jBVPwCICcnB8zi85PpcG6
 E+ud/E7kfHoau3DwJXGD0Aox7Hp6WGXseG6K6X03aBc4w0tGCtwkkypfqDha2gD9UW
 gKdvxrzLj/JzdZqWTkYR+yMnuXl+zz6XfsJNMjcoiVkCEk1vAlmu99BHeG6S1ab6CC
 5iQjGmBpE9nzox3QI4sUXc0+zvy40O2GW418xyGLli2AGLDkAtR6jj9A/r1TetWiym
 u9fP5A1N9u5KFCMBnEPfPe6sZGtvpDiPhfl2TInFBb/Fxrar9KO7q0RaQcPB0BVttE
 ZBAKsjifzR5Lg==
Message-ID: <b812e5e2-aa29-4802-99cc-72f2e83595de@denx.de>
Date: Thu, 5 Oct 2023 15:01:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/2] cmd: bind: Try to improve the (un)bind help
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231002134621.94786-1-miquel.raynal@bootlin.com>
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

On 10/2/23 15:46, Miquel Raynal wrote:
> While it may sound totally obvious for the regular U-Boot developer to
> get the parameters of the bind/unbind commands from the output of 'dm
> tree', it did not felt straightforward to me until I was explicitly
> told to look there. And even when I knew the command, I did not make a
> direct link between the arguments of this command and the columns
> returned by 'dm tree'.
> 
> Several of us lost a lot of time because of that, I would like to kindly
> help other users by slightly improving this textual line. Unfortunately,
> because of how this string is used (like within the 'help' command) I
> cannot detail much more, but at least the pointer is there.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Resend: no change.
> 
> Changes in v2:
> * Moved the details in the long text section as suggested by Heinrich.
> * Rephrased the help text as well, not fully following Heinrich
>    suggestion, but taking inspiration from it.
> ---
>   cmd/bind.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/cmd/bind.c b/cmd/bind.c
> index 4d1b7885e60..be0d4d2a711 100644
> --- a/cmd/bind.c
> +++ b/cmd/bind.c
> @@ -246,6 +246,8 @@ U_BOOT_CMD(
>   	"Bind a device to a driver",
>   	"<node path> <driver>\n"
>   	"bind <class> <index> <driver>\n"
> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> +	"their path, class, index and current driver.\n"
>   );
>   
>   U_BOOT_CMD(
> @@ -254,4 +256,6 @@ U_BOOT_CMD(
>   	"<node path>\n"
>   	"unbind <class> <index>\n"
>   	"unbind <class> <index> <driver>\n"
> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> +	"their path, class, index and current driver.\n"

'dm tree' depends on CMD_DM , you might need some if (IS_ENABLED()) here.
