Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D5FB5189
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 03:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC2C83F98;
	Tue,  7 Apr 2026 05:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="n7aG8VPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9253F83936; Tue,  7 Apr 2026 01:53:16 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78F528341A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 01:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Michael.Srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 6f628ed2346cdabb6ecb428c; Tue, 07 Apr 2026 01:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775519593; bh=W8MwkalD0LlgiZdaoztsYwK9/bd3tQAAEkyDu+OqBUo=;
 h=Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
 Content-Language:From:Content-Type:Content-Transfer-Encoding;
 b=n7aG8VPmashHWmhDRgN4DGe8Re9UOq3If8x7dJ+sY6BxiGe4pH/I9tis431YSVPrN
 bwMMjLl1xBgnwmvBSO+LG1KRug+Do09L47eaQgw0BgGLjuvHNw0kdI3vLS6M2hP/IN
 pEpK2cum2Pe6NRCYgPnZ48zEmYtlbvP5hyBbfGksYfAqduvLTq3sRgr9xYp8VOf6L+
 x+6NFOIdM1iBrmWNkTduLnYBAmk3teI5FYo53f3juXyjDPmViuqmVDbyWU8f6qq7xk
 Ec6FxKZso0RYln22PNE1wCBYx0cEzyxlmt0xcpOkpvMGkrlI0UGydM72VfWENWuIOO
 9KUgfr0vcktVQ==
Received: from [192.168.0.240] (ip-111-27.static.ccinternet.cz
 [147.161.27.111])
 by smtpd-relay-789d8dfb5c-5qc6d (szn-email-smtpd/2.0.71) with ESMTPA
 id dac2390b-5fd2-4e9f-b818-be517e5343eb;
 Tue, 07 Apr 2026 01:53:07 +0200
Message-ID: <8555f993-36da-4f4b-a6b6-2ef079618cd0@seznam.cz>
Date: Tue, 7 Apr 2026 01:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [0/5] Add SPL support for Qualcomm platforms, starting with sdm845
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <CAFLszThqzujQqjcirUf-2w6+wuXKv9+=WZ_nGjyKiKtzTkG07w@mail.gmail.com>
Content-Language: en-US
From: Michael Srba <Michael.Srba@seznam.cz>
In-Reply-To: <CAFLszThqzujQqjcirUf-2w6+wuXKv9+=WZ_nGjyKiKtzTkG07w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Apr 2026 05:01:00 +0200
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



On 4/6/26 17:48, Simon Glass wrote:
> Hi Michael,
>
> On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
>> U-Boot SPL, as it will be built using the defconfig added in this series,
>> replaces xbl_loader.
> Please can you clarify what happens on devices where XBL_SEC does not
> have this vulnerability? The code checks for EL3 and skips to reset,
> but if the SMC call to unlock secure regions fails, does the code
> handle this gracefully or crash?
The XBL_SEC ELF must be included as part of the u-boot ELF (this is what
the linker script does, yes it's cursed), so only a vulnerable one would
ever be included at build time (or if not, JTAG will be used to alter
the code flow).
Ideally a single fixed version would be included with u-boot as
an ambiguous bag of bytes that you are forced to put in your ELF to have
your actual code boot, but even if you could convince a judge that under
EU law that exempts you from copyright, under the US law you're presumably
screwed and in any case not getting sued is preferred.

In case the documentation is not clear enough on this, you absolutely
need to BYO an xbl_sec.elf (because I doubt u-boot wants to carry it,
and even if it does I'd rather not share "firmware" (using the definition
of "stuff that comes on your device and nobody ever wrote down a license
for, or just never gave it to you but that's actually not likely")).

For now unless you can find a vulnerable XBL_SEC you'll need to use
whatever you can get (e.g dumping one from existing xbl.elf on your device)
and use EUD or plain JTAG to jump to `start` from EL3.

I think it should be legal for an OEM to intentionally ship an old version
of XBL_SEC, but as for making it easily available for download that
depends on if Qualcomm distributes it to *them* with any sort
of license other than implicit  "obviously we won't sue you for using it
exactly the way we expect you to use it", and I kinda doubt they do.

To be absolutely clear, to my understanding there would be absolutely
no security detriments to qcom's precious (sadly legal) security model
if they just publicly released a stub xbl_sec that doesn't drop to EL1
before jumping to our code to linux-firmware, since the whole xbl.elf
is still signed by the OEM on the 99% of devices that put security over
freedom, but since they made the version of that which they did for google
explicitly check that it's running on an SoC fused from the factory
as intended-for-cros, I don't think they are going to do that.
Maybe it's a product segmentation thing, "how much extra can we charge
the few rare OEMs who don't want to use our super great stock bootloader".
(I don't think the idea of an end user having a say ever slips their mind)
> Regards,
> Simon

