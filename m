Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF14E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 21:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFA886D78;
	Sat,  7 Oct 2023 23:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696713025;
	bh=VfDFYOAyD0ithhcllyQRc6BaXOnI0AzYvMxSjFrSNE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yBCj4YGHMbn2txT0hTtkaiHSIrMEQn8aEDCBAhRhfD+OEAkn6ESiExC95BmDMdGSM
	 qaRL4TwwUN4K8MhjVmV2w/8CsuXQhIP5KQRYlHvQ3wbovIqmiaQm39wz65iQK6O/85
	 39j1RYczWXZhw53SrK1wD91EDOjZ6pdahqqIFS6WWJVu0WyuXnMwPIbRbi0Dt8zLeW
	 GHYLwloi6dhF0uW/frhq9BiyDWSEcIibU6+/VfTfcLqRrvy7DTLM58St61VcSIrHVQ
	 igGW/r9vpukTn4kJGu9356WEcf9BbLxV8xGLppI/NmrHsTgn8MOn48vfbdlVOAMlfS
	 yWbDG8XWbzJTA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 61E988694A;
 Sat,  7 Oct 2023 23:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696713024;
 bh=VfDFYOAyD0ithhcllyQRc6BaXOnI0AzYvMxSjFrSNE0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PM3GgyR0ux/wa2zFHPIeVlZQr3wd+q0bRT7AEi7lgUhy4bg4TYBmWF6qfS6ZChL8t
 xUspRpZoQM9yVxUIMHd+MeameCKSV55tpDqJ/QFYXkcoOaiAz0XNTpojKuKNcEXT7b
 7FRJ350Tt9Z8imxIL1b0JnrSb+1aLc6RInFVQXB5DcMfXKeck7Ca/K3I/B9/cci/hb
 cq8OjEE9swoTfVJS3MBg/lxW2wJhEzh+Du/G/kh+dlTL0oRXrudMUQ4Y9Itcwdbth5
 BR7gPA7Cn1X0UUCWSjSOWkzGC2CoQXGlvUJWTLL2PC/XoaUkdbOu1zhXfYf4oEyLhD
 lqv8aWGb9vM3Q==
Message-ID: <4e30f95b-f0be-4033-a2b3-0bc713a8da78@denx.de>
Date: Sat, 7 Oct 2023 23:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/2] cmd: bind: Try to improve the (un)bind help
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <b812e5e2-aa29-4802-99cc-72f2e83595de@denx.de>
 <20231005175443.7d042e8b@xps-13>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231005175443.7d042e8b@xps-13>
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

On 10/5/23 17:54, Miquel Raynal wrote:
> Hi Marek,
> 
> marex@denx.de wrote on Thu, 5 Oct 2023 15:01:51 +0200:
> 
>> On 10/2/23 15:46, Miquel Raynal wrote:
>>> While it may sound totally obvious for the regular U-Boot developer to
>>> get the parameters of the bind/unbind commands from the output of 'dm
>>> tree', it did not felt straightforward to me until I was explicitly
>>> told to look there. And even when I knew the command, I did not make a
>>> direct link between the arguments of this command and the columns
>>> returned by 'dm tree'.
>>>
>>> Several of us lost a lot of time because of that, I would like to kindly
>>> help other users by slightly improving this textual line. Unfortunately,
>>> because of how this string is used (like within the 'help' command) I
>>> cannot detail much more, but at least the pointer is there.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>> Resend: no change.
>>>
>>> Changes in v2:
>>> * Moved the details in the long text section as suggested by Heinrich.
>>> * Rephrased the help text as well, not fully following Heinrich
>>>     suggestion, but taking inspiration from it.
>>> ---
>>>    cmd/bind.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/cmd/bind.c b/cmd/bind.c
>>> index 4d1b7885e60..be0d4d2a711 100644
>>> --- a/cmd/bind.c
>>> +++ b/cmd/bind.c
>>> @@ -246,6 +246,8 @@ U_BOOT_CMD(
>>>    	"Bind a device to a driver",
>>>    	"<node path> <driver>\n"
>>>    	"bind <class> <index> <driver>\n"
>>> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
>>> +	"their path, class, index and current driver.\n"
>>>    );
>>>    >   U_BOOT_CMD(
>>> @@ -254,4 +256,6 @@ U_BOOT_CMD(
>>>    	"<node path>\n"
>>>    	"unbind <class> <index>\n"
>>>    	"unbind <class> <index> <driver>\n"
>>> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
>>> +	"their path, class, index and current driver.\n"
>>
>> 'dm tree' depends on CMD_DM , you might need some if (IS_ENABLED()) here.
> 
> Well, no, and that's my point actually. People need to know that this
> command exist and should be used for this purpose. If you only tell
> them "use 'dm tree'" conditionally, you loose part of the audience:
> people not aware of this command or its usefulness.

If you tell them 'Use "dm tree"' and it prints "no command found" , then 
it's a bug.

You likely want to add 'imply CMD_DM' into CMD_BIND Kconfig to make sure 
CMD_DM is available by default, but also that users can turn it off if 
they really want to.
