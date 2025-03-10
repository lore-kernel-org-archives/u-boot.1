Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6578BC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED3F80FB9;
	Mon, 10 Mar 2025 22:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741640912;
	bh=SpOo52O98saHwjVpAJ2FoJMFCYuApNr3T1ZKopWLKrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pM5K4O/9CFIcjm55iDt+UsDpQPJSNnrQ3JFn2EaTfzD5n+pzGRdKsOKP+PYHKa5NJ
	 tm19r/RDmsQNRJgHspjHLQm6PhR1XvZ3fOg+5rDK+6xMMtQcCxNZ1ZIFHQPS+LWVY5
	 QvpOFze3l7b39VVVy1/XS+AT4mryS0oayBRsf/G9TpkyaQzUQs8s+RQNBxziP1T2SF
	 dCb4VX2+hXAJQJMrC8SdaAoFH5koxCXYzkPTlqzNTTYQH8KlBnzA7kpbD7hJx00P53
	 b+98oXoXRo99Z45a1BK95jEJREhHWINT7WhO+V27NWRKHq7XeMak3EJIwQPxCpUCAc
	 bBeqC5Gqqj/mg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F54C811C1; Mon, 10 Mar 2025 22:08:30 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E98800D7
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Q5Cwgqmu"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 150CC103BB5FA; Mon, 10 Mar 2025 22:08:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741640907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=SpOo52O98saHwjVpAJ2FoJMFCYuApNr3T1ZKopWLKrM=;
 b=Q5Cwgqmu+0BULKqK3/rsvR4ezGTzcS1vDy40Vwx5d/CKJxEC09MoYEDwxhBg7p5sJr9Rv8
 Vu5GvnaaRpph0pd+h+Z8HVxIxJU+wGqC230vGN5VmlYqWl/u90FQKkXEckJ9QHagNRx1Er
 ba7FbeK6bK1D8RZi90LuLQTFhON470HF3ZgYZtys4gKauSMwdLn9CtB4Fb69G/L2aWpjkx
 wwZ07wx0ID5PLt2aFfdf5TIs50hI3f2LDshK+JfIChNQOZA/H0b5gqVJUQnAfBG4wns0z2
 8ZiTp889m6EeCXPH4rcwxrIJ4wjPD29q9edK1cyM5+prFUIPp1A8okNIo2LB9w==
Message-ID: <3edcc323-32d4-4b49-943a-858624544543@denx.de>
Date: Mon, 10 Mar 2025 21:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] fs: exfat: Add U-Boot porting layer
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-8-marex@denx.de>
 <20250310151858.GF2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310151858.GF2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/10/25 4:18 PM, Tom Rini wrote:
> On Sat, Mar 08, 2025 at 09:12:11PM +0100, Marek Vasut wrote:
> 
>> Add U-Boot adjustments to the libexfat code and integrate
>> the result into U-Boot filesystem layer. This provides full
>> read-write exfat support for U-Boot available via generic
>> filesystem interface.
> [snip]
>> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
>> new file mode 100644
>> index 00000000000..9f2703a01ee
>> --- /dev/null
>> +++ b/fs/exfat/Kconfig
>> @@ -0,0 +1,4 @@
>> +config FS_EXFAT
>> +	bool "Enable EXFAT filesystem support"
>> +	help
>> +	  This provides read/write support for EXFAT filesystem.
> 
> Since it looks like you're intentionally not adding exfat-prefixed
> commands and only using the generic_fs commands, this needs to imply
> CMD_FS_GENERIC if CMDLINE so that it can be used.
> 
>> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
>> new file mode 100644
>> index 00000000000..824237b6c26
>> --- /dev/null
>> +++ b/fs/exfat/Makefile
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +#
>> +
>> +obj-$(CONFIG_FS_EXFAT) = \
> 
> Filesystems are where we have all of the anti-patterns of "obj-... ="
> rather than "+=". It's not a you-must change, but it'd be good to be
> consistent with most of the tree.
> 
> The rest seems fine, thanks.
Fixed in v2, thanks.
