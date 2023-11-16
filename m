Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CFFC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 09:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150F587499;
	Thu, 16 Nov 2023 10:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700126867;
	bh=N+2Mny8q1Q4urnN7DpkAEBqH3BjdYTBwT19ALMp0zdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/ZyBaKY5Tp5kFXKtGxDIaN+cRVN9y6HzuIMwqrJxguvbd41vdn8TJBdiS1Km/Ehq
	 83zR2qcdRNuVXHpSYZ4ojCbzQMvBZpOQENLN18N3LYWiDv7jC4hFLMTruE7ib81pt1
	 /0y8O+ObKHJ5MR98GVDeNfGnZVvrosdfsmoWn78qs+FMFzldV141V2HqFfq7kFSwHb
	 zajRj5NEgV9TK0rDNwDSSkLFrBgsn6vaCtcP4fA6+fXfeJxSBgKAmA1CnzOKHuOfN9
	 WEKWx96agqKG7sXSCncISIcPvhy73dzPidf6kiTuEIH5wjAbGtwmz9cjW7+CppvXKi
	 tsiKdDMiyKDiA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4028749D; Thu, 16 Nov 2023 10:27:37 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7AD87497
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SWF714zwSz9sZZ;
 Thu, 16 Nov 2023 10:27:25 +0100 (CET)
Message-ID: <8b59a6eb-a593-4a68-ab92-280919ef5dc3@denx.de>
Date: Thu, 16 Nov 2023 10:27:24 +0100
MIME-Version: 1.0
Subject: Re: Error building PX30 Ringneck with WDT support
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de
References: <1ca36fad-6c54-4453-acf2-64758187c682@theobroma-systems.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <1ca36fad-6c54-4453-acf2-64758187c682@theobroma-systems.com>
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

Hi Quentin,

On 11/15/23 19:00, Quentin Schulz wrote:
> Hi all,
> 
> I'm trying to add watchdog support to the PX30 Ringneck board but it 
> fails to compile:
> 
> """
> diff --git a/configs/ringneck-px30_defconfig 
> b/configs/ringneck-px30_defconfig
> index b314636b4d9..3dab0dab5d4 100644
> --- a/configs/ringneck-px30_defconfig
> +++ b/configs/ringneck-px30_defconfig
> @@ -122,6 +122,10 @@ CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_GENERIC=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_DWC2_OTG=y
> +# CONFIG_WATCHDOG is not set
> +# CONFIG_WATCHDOG_AUTOSTART is not set
> +CONFIG_DESIGNWARE_WATCHDOG=y
> +CONFIG_WDT=y
>   CONFIG_SPL_TINY_MEMSET=y
>   CONFIG_TPL_TINY_MEMSET=y
>   CONFIG_LZO=y
> """
> 
> $ make CROSS_COMPILE="aarch64-linux-gnu-" ringneck-px30_defconfig
> $ make CROSS_COMPILE="aarch64-linux-gnu-"
> [...]
> /usr/bin/aarch64-linux-gnu-ld.bfd: lib/time.o: in function `udelay':
> /home/qschulz/work/upstream/u-boot/lib/time.c:199: undefined reference 
> to `schedule'
> /home/qschulz/work/upstream/u-boot/lib/time.c:199:(.text.udelay+0x1c): 
> relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol 
> `schedule'
> make[1]: *** [scripts/Makefile.spl:527: tpl/u-boot-tpl] Error 1
> make: *** [Makefile:2073: tpl/u-boot-tpl] Error 2
> 
> FWIW, I had this kept on a downstream U-Boot (v2022.10, on top of: 
> https://git.theobroma-systems.com/ringneck-u-boot.git/log/?h=v2022.10-ringneck) and it both compiled and worked. I assume this may be related to the "new" cyclic support?

This seems very likely.

> Looking for pointers as somehow I don't really understand the error. 
> schedule() definition seems to be existing in headers included in 
> lib/time.c so a bit clueless at the moment. Probably related to TPL also 
> as it doesn't fail in neither proper nor SPL build stages it seems.

Correct. I assume that this cyclic / WDT support was never used /
implemented with TPL. Could you please take a deeper look at this
to see, where exactly the problem originates.

Thanks,
Stefan
