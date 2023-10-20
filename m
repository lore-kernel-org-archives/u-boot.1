Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74C9CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 11:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D409687487;
	Fri, 20 Oct 2023 13:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B5A87492; Fri, 20 Oct 2023 13:58:02 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 55F6787467
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 13:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADBA52F4;
 Fri, 20 Oct 2023 04:58:38 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.95.16])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7402C3F5A1;
 Fri, 20 Oct 2023 04:57:56 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:47 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com, xueliang.zhong@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20231020115747.GA141285@e130802.arm.com>
References: <20230821210927.GL3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821210927.GL3953269@bill-the-cat>
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

Hi Tom,

> ________________________________________________________________________________________________________
> *** CID 464361:  Control flow issues  (DEADCODE)
> /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_log()
> 142
> 143             if (ffa_id < FFA_FIRST_ID || ffa_id > FFA_LAST_ID)
> 144                     return -EINVAL;
> 145
> 146             abi_idx = FFA_ID_TO_ERRMAP_ID(ffa_id);
> 147             if (abi_idx < 0 || abi_idx >= FFA_ERRMAP_COUNT)
> >>>     CID 464361:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "return -22;".
> 148                     return -EINVAL;

This is a false positive.

abi_idx value could end up  matching this condition "(abi_idx < 0 || abi_idx >= FFA_ERRMAP_COUNT)".

This happens when ffa_id value is above the allowed bounds. Example: when ffa_id is 0x50 or 0x80

	ffa_print_error_log(0x50, ...); /* exceeding lower bound */
	ffa_print_error_log(0x80, ...);  /* exceeding upper bound */

In these cases "return -EINVAL;" is executed.

> ... 
> ________________________________________________________________________________________________________
> *** CID 464360:  Control flow issues  (NO_EFFECT)
> /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 207 in ffa_get_version_hdlr()
> 201             major = GET_FFA_MAJOR_VERSION(res.a0);
> 202             minor = GET_FFA_MINOR_VERSION(res.a0);
> 203
> 204             log_debug("FF-A driver %d.%d\nFF-A framework %d.%d\n",
> 205                      FFA_MAJOR_VERSION, FFA_MINOR_VERSION, major, minor);
> 206
> >>>     CID 464360:  Control flow issues  (NO_EFFECT)
> >>>     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "minor >= 0".
> 207             if (major == FFA_MAJOR_VERSION && minor >= FFA_MINOR_VERSION) {

Providing the facts that:

#define FFA_MINOR_VERSION		(0)
u16 minor;

Yes, currently this condition is always true:  minor >= FFA_MINOR_VERSION

However, we might upgrade FFA_MINOR_VERSION in the future. If we remove the "minor >= FFA_MINOR_VERSION" ,
non compatible versions could pass which we don't want.

To keep this code scalable, I think it's better to keep this condition.

> ...
> ________________________________________________________________________________________________________
> *** CID 464359:    (PASS_BY_VALUE)
> /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 168 in invoke_ffa_fn()
> 162      * @args: FF-A ABI arguments to be copied to Xn registers
> 163      * @res: FF-A ABI return data to be copied from Xn registers
> 164      *
> 165      * Calls low level SMC implementation.
> 166      * This function should be implemented by the user driver.
> 167      */
> >>>     CID 464359:    (PASS_BY_VALUE)
> >>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) by value, which exceeds the low threshold of 128 bytes.
> 168     void __weak invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)

We are using invoke_ffa_fn with the same arguments as in linux. The aim is to use the same interfaces as in the Linux FF-A
driver to make porting code easier.

In Linux, args is passed by value [1].
ffa_value_t is a structure with 18 "unsigned long" fields. So, the size is fixed.

[1]: invoke_ffa_fn arguments in the Linux FF-A driver

https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa/driver.c#L115
https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa/driver.c#L54
https://elixir.bootlin.com/linux/v6.6-rc6/source/drivers/firmware/arm_ffa/common.h#L15

[2]: include/linux/arm-smccc.h

> 169     {
> 170     }
> 171
> 172     /**
> 173      * ffa_get_version_hdlr() - FFA_VERSION handler function
> /drivers/firmware/arm-ffa/ffa-emul-uclass.c: 673 in invoke_ffa_fn()
> 667      * invoke_ffa_fn() - SMC wrapper
> 668      * @args: FF-A ABI arguments to be copied to Xn registers
> 669      * @res: FF-A ABI return data to be copied from Xn registers
> 670      *
> 671      * Calls the emulated SMC call.
> 672      */
> >>>     CID 464359:    (PASS_BY_VALUE)
> >>>     Passing parameter args of type "ffa_value_t" (size 144 bytes) by value, which exceeds the low threshold of 128 bytes.
> 673     void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)

Same feedback as above.

Cheers,
Abdellatif

