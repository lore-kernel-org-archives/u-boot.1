Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D5C07E97
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CEB86FF7;
	Wed, 29 Nov 2023 20:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7410F875A7; Wed, 29 Nov 2023 20:16:31 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CF2486E6B
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1r8Q2o-0003uT-2z; Wed, 29 Nov 2023 20:16:22 +0100
Message-ID: <62e767da-5e4f-4b92-a5c9-5d523896d68e@pengutronix.de>
Date: Wed, 29 Nov 2023 20:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Masahiro Yamada <masahiroy@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <20231129190220.GN2513409@bill-the-cat>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231129190220.GN2513409@bill-the-cat>
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

Hello Tom,

On 29.11.23 20:02, Tom Rini wrote:
> On Wed, Nov 29, 2023 at 07:59:00PM +0100, Ahmad Fatoum wrote:
>> Hi,
>>
>> a few more comments after decompiling the FIT image:
>>
>> On 29.11.23 18:21, Simon Glass wrote:
>>> +    with fsw.add_node('kernel'):
>>> +        fsw.property_string('description', args.name)
>>> +        fsw.property_string('type', 'kernel_noload')
>>
>> The specification only says no loading done, but doesn't explain what it
>> means for a bootloader to _not_ load an image. Looking into the U-Boot commit
>> b9b50e89d317 ("image: Implement IH_TYPE_KERNEL_NOLOAD") that introduces this,
>> apparently no loading means ignoring load and entry address?
>>
>> I presume missing load and entry is something older U-Boot versions
>> were unhappy about? Please let me know if the semantics are as I understood,
>> so I can prepare a barebox patch supporting it.
> 
> So the matching side for this series in U-Boot is:
> https://patchwork.ozlabs.org/project/uboot/list/?series=382849&state=*
> 
> And in short, for IH_TYPE_KERNEL_NOLOAD we do our best to use it
> in-place. For decompression we allocate some space to decompress to.

Thanks. I am still curious why "kernel" couldn't have been used back then
with missing entry and load address to arrive at the same result?

Thanks,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

