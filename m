Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4B9CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 03:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92F0836A3;
	Thu, 25 Sep 2025 05:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FADC836A7; Thu, 25 Sep 2025 05:39:34 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A92283678
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 05:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [143.105.119.198])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5B627B2201CA;
 Thu, 25 Sep 2025 05:39:29 +0200 (CEST)
Message-ID: <38f4cdaa-6fd8-418b-b599-dbe67e6736cd@freeshell.de>
Date: Wed, 24 Sep 2025 20:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT,PULL] u-boot-riscv/next
From: E Shattow <e@freeshell.de>
To: Tom Rini <trini@konsulko.com>, Leo Liang <ycliang@andestech.com>,
 Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de, rick@andestech.com, randolph@andestech.com,
 hal.feng@starfivetech.com, jamie.gibbons@microchip.com,
 eoin.dickson@microchip.com, wangruikang@iscas.ac.cn,
 greentime.hu@sifive.com, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <aM5_0WpehgnK8wH-@swlinux02>
 <175839044541.1370912.7338002899133591795.b4-ty@konsulko.com>
 <1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de>
Content-Language: en-US
In-Reply-To: <1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de>
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


On 9/24/25 19:07, E Shattow wrote:
> Hi Tom, Leo, and Yao,
> 
> On 9/20/25 10:47, Tom Rini wrote:
>> On Sat, 20 Sep 2025 18:20:01 +0800, Leo Liang wrote:
>>
>>> The following changes since commit a209627ed7921f40669f5c0795570d40e77e4cb7:
>>>
>>>   Merge patch series "board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()" (2025-09-16 16:14:30 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
>>>
>>> [...]
>>
>> Merged into u-boot/next, thanks!
>>
> 
> Runtime regression for VisionFive2 SPL bisected to bad commit
> a681cfecb434 "riscv: Add a Zalrsc-only alternative for synchronization
> in start.S". Confirmed by checking out origin/next (to 44c4919e9 "test:
> Fix optee unit test") and reverting that commit a681cfecb434 only.
> 
> I am late to testing this, sorry about that. It would have been better
> to catch this before becoming part of a range of bisect commits that now
> have a non-functional SPL on visionfive2.
> 
> Best regards,
> 
> -E

P.S. for Yao, there are problems with your series more than the one bad
bisect commit only. Build starfive_visionfive2_defconfig with ordinary
toolchain from Debian 13 Trixie gcc 14.2.0 and any StarFive2 (or
variant) board, to see the problem. I can't get this working with only
config changes and your series for a fixes follow-up. Too heavy of a
change... revert the series please. -E
