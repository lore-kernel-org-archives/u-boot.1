Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DBCC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 20:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE02986E42;
	Wed, 29 Nov 2023 21:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67C686D33; Wed, 29 Nov 2023 21:35:16 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A9E86B9A
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 21:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1r8RH1-0006ZB-Pk; Wed, 29 Nov 2023 21:35:07 +0100
Message-ID: <2746082e-4357-4608-8fd9-ffbd1ecd6ac2@pengutronix.de>
Date: Wed, 29 Nov 2023 21:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
 <CAPnjgZ1e4cryN=Q8XufrdEcJoHfW5n-aN-F3pr2mTWA_0c5-Gg@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAPnjgZ1e4cryN=Q8XufrdEcJoHfW5n-aN-F3pr2mTWA_0c5-Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

On 29.11.23 20:00, Simon Glass wrote:
> On Wed, 29 Nov 2023 at 11:35, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> Doesn't hardcoding a load address and entry address here defeat the point
>> of having FIT as generic portable image format?
>>
>> At least barebox will try to place the kernel image at physical address 0 and
>> will exit with an error message if no SDRAM is located at that address.
>> The recommendation in that case is to omit load and entry address altogether
>> to have barebox find a suitable location, but I see now that the FIT specification
>> requires a load and entry address. What would happen if U-Boot tries to load this
>> FIT image on a board that has no DRAM at address 0?
> 
> The 'kernel_noload' type indicates that the load/exec address are ignored.

Can the script not insert load/exec addresses with dummy values to avoid confusion?

>> Please Cc me on subsequent revisions. I am interested in testing that this works for barebox
>> too.
> 
> There has been some discussion about this recently in U-Boot too,
> along with a series [1] which you could try if you like.

Thanks for the pointer. I have just sent out a first patch to add support
for kernel_noload to the barebox mailing list[1]. With that change applied,
barebox can boot the FIT images generated by this series.

Once that's accepted, I'll reply with a Tested-by.

[1]: https://lore.barebox.org/barebox/20231129203106.2417486-1-a.fatoum@pengutronix.de/T/#u

> The FIT spec[2] does not provide enough detail on exactly what
> kernel_noload means and we should improve this at some point.

Yes, that would be nice. Also straight references to e.g. U-Boot configuration
symbols could use some rewording.

Thanks,
Ahmad

> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=382849
> [2] https://github.com/open-source-firmware/flat-image-tree
> 
> 
> 
>>
>> Thanks,
>> Ahmad
>>
>> --
>> Pengutronix e.K.                           |                             |
>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

