Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12661C369D5
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 07:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A8AB810EB;
	Sun, 27 Apr 2025 09:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D7781E0F; Sun, 27 Apr 2025 09:47:34 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7587A80FDE
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.61.227])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3D435B4C1BD2;
 Sun, 27 Apr 2025 09:47:31 +0200 (CEST)
Message-ID: <53c01ebd-2f88-4887-a3e4-f10a4537b1df@freeshell.de>
Date: Sun, 27 Apr 2025 00:47:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] u-boot-riscv/master
To: Tom Rini <trini@konsulko.com>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
References: <aAte-nS8ZhO_Odw1@swlinux02>
 <174562459055.746741.13011026537921584133.b4-ty@konsulko.com>
 <756019b8-60f6-4cab-92b0-cd1e857a375c@freeshell.de>
 <20250426141428.GY5495@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250426141428.GY5495@bill-the-cat>
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

Hi, Tom!

On 4/26/25 07:14, Tom Rini wrote:
> On Fri, Apr 25, 2025 at 06:13:38PM -0700, E Shattow wrote:
>> The outcome of that merge went a bit weird for
>> board/starfive/visionfive2/spl.c
>>
>> On 4/25/25 16:43, Tom Rini wrote:
>>> On Fri, 25 Apr 2025 18:07:54 +0800, Leo Liang wrote:
>>>
>>>> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
>>>>
>>>>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
>>>>
>>>> [...]
>>>
>>> Merged into u-boot/master, thanks!
>>>
>>
>> # The fix:
> 
> Sorry! Can you submit as a proper patch? I'll apply it quickly.  Thanks!
> 

Okay, sent [1] with expanded scope to also ordering duplicate of this
same EEPROM checking logic in adjacent code.

Tested on Pine64 Star64.

1: https://lore.kernel.org/u-boot/20250427060301.709506-1-e@freeshell.de

Thanks!

-E
