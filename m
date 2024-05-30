Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01918C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 01:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E3388678;
	Thu, 30 May 2024 03:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717033172;
	bh=+rfJmo/KABInbAJdGlj7kmqA7gGhNU3RqlnodCdpCMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/rsB/5WNzFLHA5YJLgjDcScbMd7h9NLWyrzqWvlxMyzSvokbjmY2p2mRfpiudN9O
	 jRdUM2UfHUoQExq0fiJmzzRorSWYv0IJU/4ioXsf0N3e0MH/E19Pm1s0L/+aGRDjXK
	 TmTSKH2acS7hcRAPT01G8CxeNFi/TL1l6JRXQ76yt1uvuoSnjru5JyO6IqV0VfgfKn
	 JvJAD6XrZsut65QGCI5zK5ceIuPTKlBO13uuUE0eClcxqcMNDnkFBSY/PpRZthUOgj
	 fKuVw5tfl5POM9C20npdhP7BHUSCm2CcP1wQEMVpmzIxTNPrIcNmGeg3gz5FHFyLOS
	 eXfeWU1Tztz/Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 340CD87EF7;
 Thu, 30 May 2024 03:39:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717033170;
 bh=+rfJmo/KABInbAJdGlj7kmqA7gGhNU3RqlnodCdpCMI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vzBHoXAnGz1jDcPae95D12ecS/fomccd3yq5FA/ItwrlK+xcZyGZjP9sDVGkBLiSF
 3GS36OMin+Ts+y/opOKOUss0j41uyj2/pn0MhlUr7hAN+qmyb50JNql8i+vZq+5oQ3
 UHCNjute3JHw6PchUOKcPSBCWn2toTZu1wG1AHPcGqUUDIW5/hWbR66FyMODt7Iwoi
 vNEOgQspvLucH/N4S6KiVTgG5YpdF1N56Y0mf036yhwg5h78JKmE/iER+JlrmFdfId
 PmDXhTNM/EX525mI9lQ95dWARPHUbQGb/yRAv4NciuGXdn9hHbNskpO+DXtrS1ySo1
 fJ28xvL+C2KAA==
Message-ID: <744a2f92-18d1-4830-98c0-c6c686cd11ef@denx.de>
Date: Thu, 30 May 2024 03:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240525200249.3904352-1-tharvey@gateworks.com>
 <CAFLszTifTgSGjAZ-t7-7q6FYRjQ1kfH6hn2dw-hb0PK-2Z3WRg@mail.gmail.com>
 <CAJ+vNU1yQaLgW5f1tSHiZtbWQ_7GPs87GV3FHNK3uvCiFpLvZw@mail.gmail.com>
 <CAFLszTjwuDeQ=xxF8cpMoHmpVPVDkeKKM1a8QRGmVLFzCU=ZSA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTjwuDeQ=xxF8cpMoHmpVPVDkeKKM1a8QRGmVLFzCU=ZSA@mail.gmail.com>
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

On 5/29/24 7:05 PM, Simon Glass wrote:

[...]

>>>> that is not yet implemented as DM_RNG. We also skip this if
>>>> MEASURED_BOOT is enabled as in that case any modifications to the
>>>> dt will cause measured boot to fail (although there are many other
>>>> places the dt is altered).
>>>>
>>>> As this fdt node is added elsewhere create a library function and
>>>> use it to deduplicate code. We will provide a parameter to specify the
>>>> index of the rng device as well as a boolean to overwrite if present.
>>>>
>>>> For our automatic injection, we will use the first rng device and
>>>> not overwrite if already present with a non-zero value (which may
>>>> have been populated by an earlier boot stage). This way if a board
>>>> specific ft_board_setup() function wants to customize this behavior
>>>> it can call fdt_kaslrseed with a rng device index of its choosing and
>>>> set overwrite true.
>>>
>>> I suggest creating a sysinfo driver which can provide the RNG device.
>>
>> I'm not really clear what you mean but that seems out of scope for
>> this patch. If/when someone needs to extend the functionality of
>> specifying one of many RNG's perhaps they can follow that approach.
> 
> The thing is, you are creating a way to specify the RNG which will
> presumably lead to different vendors all doing it a different way.
> 
> Specifically, fdt_kaslrseed() takes a device number (would be better
> to take a struct udevice, BTW).
> 
> Instead, I think you should define the standard way that the chosen
> RNG should be specified by the board. The sysinfo driver can provide a
> way to do this. Then boards can handle this themselves, using sysinfo,
> rather than directly calling a function in the fixup. After all, we
> want the fixup flow to be as generic as possible.

I think this patch simply picks up the first RNG that is available, 
pulls a number out of it, and uses that as the KASLR seed in DT. That's 
what the implementation(s) seems to be doing so far, this patch is a 
deduplication only, so maybe we should retain the original behavior 
first, and do architectural changes in follow up patch(es) ?
