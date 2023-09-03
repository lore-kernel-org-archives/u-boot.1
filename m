Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC7C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 08:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0528144A;
	Sun,  3 Sep 2023 10:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="mPQGYWeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC8B80DF7; Sun,  3 Sep 2023 10:17:30 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91EF8144A
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 10:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=h4Cd6XheZ1KyVphKWuvh5WMbBHrA/lgVgOHKRicqxa0=;
 b=mPQGYWeTmnmtQ+4JJnfpcUahJxon5TDZ2vjm63Rhl9xKdk6WEQGgCGi2XoUqaLgI6KdX
 BpGSLx4F2z76UtYtxG0Y/K6L74BgH0HJ6J3orq0qPCvJ+p7XLRNSbG4qPEK6C4USqB1p6T
 qD0s04gK8B2bKRT9TavUPghWJbySqaq49QC446qpssznQvpi1c4c6gnWIeguo5xxax3EeO
 +1qyBiyGLG5ftsi3asgvZsYHFLPNvmZvo5IALo9Tx5r6RNnFYcXF4kyWLhB9Eq3QjKnNPJ
 UXqATlEn+pwY8jczZaqchr8DTEJSXkJSIFrwF0SYisSlhxeDCFUmHKJulojGaBTQ==
Received: by filterdrecv-66949dbc98-mtdwq with SMTP id
 filterdrecv-66949dbc98-mtdwq-1-64F44116-8
 2023-09-03 08:17:26.326324131 +0000 UTC m=+6068545.576114068
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id znDJN7CtTnmtTsFu2N7dgQ Sun, 03 Sep 2023 08:17:25.960 +0000 (UTC)
Message-ID: <cb381ee1-fbbf-54b3-873a-d3003cc4b528@kwiboo.se>
Date: Sun, 03 Sep 2023 08:17:26 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230731224304.111081-6-sean.anderson@seco.com>
 <ZMtl65DZ0NmO7pZO@xdrudis.tinet.cat>
 <4546689a-5b75-9ae3-3dd8-1a15bf896b5a@seco.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4546689a-5b75-9ae3-3dd8-1a15bf896b5a@seco.com>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h8aGp4B9djA480Vsu?=
 =?us-ascii?Q?202tVarAIMDrNzserP7k9Kes6xJv=2FL9iLZKy69U?=
 =?us-ascii?Q?lTC2DkzcDkgTHLxQHdIf9sZUWKklNExLpDKZkFU?=
 =?us-ascii?Q?4BshmeN=2F19P+4Gcew44rbTX5Z2wbdDvFwZhEG1K?=
 =?us-ascii?Q?h3xz7Krg0QlBg40JWUY2qI+ZN5X4OLO6BZzp3e?=
To: Sean Anderson <sean.anderson@seco.com>, Xavier Drudis Ferran
 <xdrudis@tinet.cat>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Pali =?iso-8859-1?b?Um9o4XI=?= <pali@kernel.org>, Stefan Roese <sr@denx.de>,
 Marek =?iso-8859-1?b?QmVo+m4=?= <marek.behun@nic.cz>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut
 <marex@denx.de>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

On 2023-08-03 18:11, Sean Anderson wrote:
> On 8/3/23 04:31, Xavier Drudis Ferran wrote:
>> El Mon, Jul 31, 2023 at 06:42:57PM -0400, Sean Anderson deia:
>>> This converts the mmc loader to spl_load. Legacy images are handled by
>>> spl_load (via spl_parse_image_header), so mmc_load_legacy can be
>>> omitted.
>>>
>>
>> Yes. I haven't used the legacy case, but by looking at the code, it
>> seems to me that mmc_load_legacy left the image at some mapped memory
>> at [ spl_image->load_addr,   spl_image->load_addr + size )
>> and the new code does too, but when the image is not aligned, the
>> memory that gets written to
>> was at [ spl_image->load_addr,   spl_image->load_addr + size + spl_image->offset % mmc->read_bl_len )
>> and it will
>> be at [ spl_image->load_addr - spl_image->offset % mmc->read_bl_len,   spl_image->load_addr + size )
>> after this patch.
>>
>> Meaning both with or without this patch some memory outside the image
>> gets written when the image is not aligned on media, but before it was
>> some part of a block at the end and now is that part before the
>> beginning.
>>
>> Whether that's better or worse I don't know. It depends on whether
>> it's a problem to write in non mapped memory, whether there's
>> something worth preserving there, and whether some SOC has some sort
>> of special behaving memory just there, like it happened with the issue
>> Jerome Forissier found (note in this case it wasn't legacy, it was
>> simple fit)
> 
> Fundamentally, we can't really deal with unaligned images without a
> bounce-buffer. The method used by SPL_LOAD_FIT_IMAGE_BUFFER_SIZE will
> continue working, since we call into the FIT routines to load the image.
> I would like to defer bounce buffering for other images until someone
> actually needs it.
> 
> Note that in the FIT case, you can also do `mkimage -EB`, at least if
> you aren't using FIT_LOAD_FULL.

With the following two commits introduced in v2023.04-rc1, the alignment
issue for Rockchip has been fixed and all external data is now accessed
block aligned.

9b2fd2d22852 ("binman: Add support for align argument to mkimage tool")
5ad03fc77dfa ("rockchip: Align FIT image data to SD/MMC block length")

Regards,
Jonas

> 
> --Sean
> 
>> https://patchwork.ozlabs.org/project/uboot/patch/c941d835a85255ff81a21c72069c3a9fc9a8a255.1656489154.git.jerome.forissier@linaro.org/
>>                                                                   
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>> Changes in v5:
>>> - Rework to load header in spl_load
>>>
>>>  common/spl/spl_mmc.c | 91 ++++----------------------------------------
>>>  1 file changed, 8 insertions(+), 83 deletions(-)
>>>

[...]
