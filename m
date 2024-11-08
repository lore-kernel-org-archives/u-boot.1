Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58839D5C0FB
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCA788FFC;
	Fri,  8 Nov 2024 17:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731082629;
	bh=b+OBruHl5QhpPWTzWWrShoeYsRf5+lreVJ2CSkOW0Z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h1vn1bhCGpe5blbPu9bNyvbz4rwlKAdEzJaMRIQSlLtJHSHbUukoGXi5mkDYdymHb
	 xhGo25xwXJdnkVpXu1hCv/LarbwEXmcUoXTbq0uoyKE7smdpNGZcg7UmS6PBiw/Fzx
	 zc8X4nJz6pCx+H8zX2py3cLBeqtV0ZKPpdTA1RvVlgeIlBI1K/l7KKJanImstX+y0Y
	 5XlyT806Ra2tOTK9o0TJzOfZgCyB+EVxEQ0zZvyKFQHVefcP1aKTjlT9Aod+ejaM0i
	 ZHFeysfX+InH4T5AzVn/yKkwtnAlcX9Kc1HnLfgz03lvczY0+CWfYsqKhIFfCwYjk1
	 lrlIXCYSk2jzw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 44DB888B1F;
 Fri,  8 Nov 2024 17:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731082628;
 bh=b+OBruHl5QhpPWTzWWrShoeYsRf5+lreVJ2CSkOW0Z4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jGRzXXstDKgsnuvn8HWEM+xkSCE165bYx+6Qx/7yJ9XjWeXLfUGXDp59m59dAvbOb
 yzdErlSSIivDCaZ80SInXrxD4r16XSnaq0q6d2UZpx3OGruHTX6erm8qLc1+BolUIa
 8DQPtDeXGMC9iMSjiDeCrNBpHiEfytL+c8EgqDW+A+KdaGHTcLgrnAZcEWF5MF2yzI
 dhZD31Y6RiJIjwTk/5CH9c41WVcrfQrAXu7D/I9llS4sQMdcKcpuBcq+uzDWCHDiK6
 fS42s+jc8BLOAv5pXDo/a47W8ceu6ilbfePaiQAfZhXnFrH7arLvh0xGdgZ7HTEjGa
 5742hXwCuUYJA==
Message-ID: <bf90d794-7b70-4e9a-ae79-fd9297f2a0fc@denx.de>
Date: Fri, 8 Nov 2024 16:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: imx: Convert i.MX8M flash.bin image
 generation to binman
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com,
 lukma <lukma@denx.de>
References: <20240423183247.335791-1-marex@denx.de>
 <20240423183247.335791-3-marex@denx.de>
 <CAHCN7x+Moru3HsU8VUZ5z53ix2s09qG0UpwgYeh9dPEC81s3uw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAHCN7x+Moru3HsU8VUZ5z53ix2s09qG0UpwgYeh9dPEC81s3uw@mail.gmail.com>
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

On 11/7/24 2:55 AM, Adam Ford wrote:
> On Tue, Apr 23, 2024 at 1:33 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Rework the flash.bin image generation such that it uses the new binman
>> nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
>> order using plain binman, without any workarounds or sections assembled
>> in special DT node order.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
> 
> This introduced a regression on the 8M Nano with
> CONFIG_FSPI_CONF_HEADER set.  As is, the board doesn't appear to do
> anything.
> 
> Looking at the binary blob that is generated, the offset for the SPL
> phase is missing, so SPL starts at 0x5c0 instead of 0x1000, but adding
> offset = <0x1000> isn't sufficient.
> 
> Adding the offset = <0x1000>  starts the SPL phase, but it hangs right
> away and doesn't past the version message:
> U-Boot SPL 2024.07-rc1-00155-g37e50627ef-dirty (Nov 06 2024 - 19:16:52 -0600)
> 
> <hangs here>
> 
> I have only tested this on a Nano, but I think the issue would likely
> affect Plus since their boot ROM is similar.  I currently don't have a
> Mini in my possession right now, so I cannot verify the behavior on
> it.

I think Lukasz was able to reproduce it on Mini. I have a few Mini here, 
but none of them use FSPI.

iMX8MP never supported FSPI ?

>  From what I can tell, reverting this patch appears to restore boot
> operation.   I don't know enough about the mkimage tool, but I have
> tried changing  nxp,boot-from and that doesn't seem to fix it either.
> 
> When I diff the binaries, it looks like a fairly significant about of
> the values have changed, but the various magic numbers and offets
> appear correct.  This makes me wonder if setting the offsets being
> passed to mkimage are getting in the way.
> 
> If remove the references to  CONFIG_FSPI_CONF_HEADER in the device
> tree, a regular image is built.  I then use dd to create a new file
> which has the FSPI header at 0x400, and moves the beginning of the
> rest of the image to 0x1000.  This process boots the board just fine.
> This leads me to believe that something in the imx8 mkimage tool is
> doing something different when fspi is enabled.

[...]

> I'd like to rework the binman to build a standard flash.bin without
> the Flexspi stuff, then create a second file like fspi.bin (or
> something similar) which inserts the FSPI header at 0x400 and then
> just places the entirely of flash.bin contents placed at 0x1000 in a
> way that doesn't pass these offsets to imx8 mkimage tool.

That looks like a workaround . It would be much better if binman would 
generate suitable flash.bin blob with FSPI header. Maybe the FSPI header 
needs to be generated by binman using yet another etype, and the 
SPL/U-Boot have to be positioned properly according to the binman node 
content in imx8mm-u-boot.dtsi ?

(I also have hard time with binman tool)
