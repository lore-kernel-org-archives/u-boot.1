Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3254BFF6E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 22:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1738A841E2;
	Tue, 17 Mar 2026 23:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="fV01Rtd4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC2F84242; Tue, 17 Mar 2026 18:25:30 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96006842EF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7408610DDA4; Tue, 17 Mar 2026 18:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773768328;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=pqcqmWrUQEyIeDVt0KiW+UGp+By7xbs8GFJ4Z+KEA8E=;
 b=fV01Rtd4PsuTN4ntbi+TPQqfXbfn/i4Yu3+YfWMWNi+9O7hHWNbzQitcAXmMtofJmNLBlc
 4DWSCbm+MtWEK032tTi1vzJld0yC+BMRdIVRxX+QHreNNsaWWkPME2UQ46qIe8NKwm6H1h
 n34ZwS6X/utYdwZMyBYK/ttnwObMN4VIWB5cj1bHuAhBBlHjTYm89FZdz6pFdjn3Yx6328
 d8hwImsBz7Fd6DnFsN1LdG9HjhZnSlfbk7gQ5NJBnKnJaxsUxcwIWNDpddHiNiPJHotsvV
 T/jps3xY7R9QXtm+pXDmxmWvjmRaE7lJ6i86pAdqo33CPcZlkcTUjmk9vxjOig==
Message-ID: <195fc5c9-6f0c-46e0-b18e-7d390bd7c4a3@nabladev.com>
Date: Tue, 17 Mar 2026 18:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm: mach-imx: Add command to expose QB
 functionality
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <2c33ee004dd272b8427b3d1962ade06cbb220149.1773648510.git.simona.toaca@nxp.com>
 <1e3b41bf-b6fe-4307-b6d1-dbc3ce0615e0@nabladev.com>
 <e4vlh2qtw64fa4kdwdzyt6v7fmtzg3bsgihni7bksfv3bs5ivu@5ucadvhzs6he>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <e4vlh2qtw64fa4kdwdzyt6v7fmtzg3bsgihni7bksfv3bs5ivu@5ucadvhzs6he>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 17 Mar 2026 23:04:49 +0100
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

On 3/17/26 4:28 PM, Simona Toaca wrote:

[...]

>>> +	if (!cp) {
>>> +		printf("%s cp is null\n", __func__);
>>
>> What does this error output even mean ? The user will be confused, please
>> reword it.
>>
> 
> Looking at this, these error messages might be redundant, as U-Boot displays
> the command usage anyway if CMD_RET_USAGE is returned. The repeatable error is
> also redundant because the command is declared repeatable.
> 
> I have a suggestion: I could use the U-Boot API for commands from
> include/command.h (U_BOOT_CMD_WITH_SUBCMDS), which declares and registers
> do_<cmdname> with the default method body (which is almost the same as this
> version). This would imply no actual error messages, just printing the usage,
> and a cleaner code.

Aren't the error messages helpful to the user to determine what went 
wrong during the command execution ?

[...]

>>> +++ b/arch/arm/mach-imx/imx9/Makefile
>>> @@ -15,5 +15,7 @@ obj-y += imx_bootaux.o
>>>    endif
>>>    ifeq ($(CONFIG_IMX_SNPS_DDR_PHY_QB_GEN),y)
>>> -obj-y += qb.o
>>> +ifneq ($(CONFIG_XPL_BUILD),y)
>>> +obj-$(CONFIG_CMD_IMX_QB) += qb.o
>>> +endif
>>
>> This shoudld be part of 1/5 , should it not ?
> 
> And squash commits 1 and 2, as this is cmd_qb related?

No, only add the qb.o Makefile entry in 1/5 , since qb.c is added in 1/5 
too.
