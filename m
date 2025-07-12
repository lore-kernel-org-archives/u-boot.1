Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EEBC83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 03:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20755803DF;
	Sat, 12 Jul 2025 05:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18C62805D7; Sat, 12 Jul 2025 05:03:46 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EAC80194
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 05:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.24.39]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E3AE0B4D1033;
 Sat, 12 Jul 2025 05:03:42 +0200 (CEST)
Message-ID: <417acdec-67e7-4aca-9942-de34b19c4fe6@freeshell.de>
Date: Fri, 11 Jul 2025 20:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Looking for mentoring submitting my patch for SYS_BOOTM_LEN
 adjustement for riscv
To: Martin Herren <sputnik@on-the-web.ch>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <ZuEBDA2GKTZJzMfYunZN62OM1OpnpKwMbwVlOleqz1CUxcyor7Hpb0FivfZzPJQxk36MFaqr9-ut_SbeSHmh8XwvkEdeWtTVLVQTLqq-Om4=@on-the-web.ch>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZuEBDA2GKTZJzMfYunZN62OM1OpnpKwMbwVlOleqz1CUxcyor7Hpb0FivfZzPJQxk36MFaqr9-ut_SbeSHmh8XwvkEdeWtTVLVQTLqq-Om4=@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8
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

Hi Martin,

On 7/10/25 14:50, Martin Herren wrote:
> Hello all,
> 
> My first post here. Is there someone willing to mentor me to submit my first patch ?
> 
> The patch is the following 3 commits:
> https://github.com/u-boot/u-boot/compare/master...MartinHerren:u-boot:set_default_sys_bootm_len_for_riscv
> 
> It adjusts the SYS_BOOTM_LEN for RISCV to the most commonly used value.
> 
> For context, working on rebasing the Allwinner D1 branch on some u-boot fork to up-to-date U-Boot I saw that the strange way in which SYS_BOOTM_LEN was patched in Yocto's meta-riscv layer was not working anymore, so I tried a clean fix and thought an adjustment of the SYS_BOOTM_LEN's default for riscv might make sense.
> 
> So if anyone is willing to mentor me in submitting this patch this would be welcome !
> It is mostly the patman part that is still a big unknown for me and i'm afraid of spamming far too many people trying by myself otherwise.
> 
> Or does this patch not make sense at all ?
> 
> Thanks !
> 
> Martin

Without comment to the content of your patch series I think such review
happens on the mailing list and in that way patchwork [1] can track it
and it's just how things seem to be done for U-Boot upstream. Please do
format-patch and send-email your series with a cover letter to the
mailing list.

1: https://patchwork.ozlabs.org/project/uboot/list/

Best regards,

-E Shattow
