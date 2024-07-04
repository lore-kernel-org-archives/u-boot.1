Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5228C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 04:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACCD88837;
	Thu,  4 Jul 2024 06:29:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720067340;
	bh=RqppZPuiJYXgUUzs0BSwjJ1GspoPjPiLKSjbrhCC5ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=x/Aw0U9cEeEOfjxo2l0Gtgl0lL7yfzN1+ganlZzhAko2KdQC95KQdjR8J3cGx67SZ
	 4mQK5Do4+9yUbuk6WBxEThZKeBpER8IycSezwnHNxvdp/bBP411sEPmsAme6Ik9qq1
	 YJIxfTBA66zllIwrjuGmCwodD092sxxtaj1W4WIjJUYJBu0QnCPfFyiJH5DJUw2Un7
	 gVD/nNmlAOODT5nU6WGil7Ib/TDulmGJ76Y/vH2X5dKENa9EeiX+vyCSFiu1/vEHPn
	 cGJESXUayTxbGxLEwbIttZDzGtrF18PW7OUJW8vIs8YN1P6q137ZMPXAv0OQ/9W198
	 p6ASPc54SdQSQ==
Received: from [192.168.1.107] (87-97-108-210.pool.digikabel.hu
 [87.97.108.210])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AAF5B885C4;
 Thu,  4 Jul 2024 06:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720067339;
 bh=RqppZPuiJYXgUUzs0BSwjJ1GspoPjPiLKSjbrhCC5ag=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=QsPp5Y7K0/lf2N1c3aunTPJlmsfeFMhwlCjZgpk3jSKnrDjdSRN2bqk80IWfgVIdz
 ELIYTVrFUY77K3Pk0VOkV6dz2P9VT/UG2Jtn60uC1G8z4HKZlCqYgfz7QgEMkeWhzx
 owp5hjXycwSbTf3Wqow4Au839ds/MxyzJAcZ5obJkAz68PpX+5SBDHlOJHJGAwccYw
 J3p2ueaJfvcQHSFpqixBGpyMAI0142j7wuYhl0Xzl8eQho3+6Voah++yMqnMtWKrcz
 Qe3S0lPhc5038/yJJrYlN1VbN6FPnwUm9SjdSkedsOuEnNAx/8zsEVGJM6L2hiC3Ki
 hSwWNfy+tXZVA==
Message-ID: <8f3a7059-6330-f332-8e9f-729b853e001e@denx.de>
Date: Thu, 4 Jul 2024 06:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/4] fs: ubifs: Fix crash and add safeguards
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Hans de Goede <hdegoede@redhat.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240703101258.1670825-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexander,

On 03.07.24 12:12, Alexander Dahl wrote:
> Hei hei,
> 
> filesystem handling is different in U-Boot and beyond that UBI/UBIFS is
> different from other filesystems in U-Boot.  There's UBI and UBIFS code
> ported from Linux (quite old already now, maybe someone wants to update
> that?), and there's "glue code" or "wrapper code" to interface with
> U-Boot scripts, commands, and filesystem handling.  The fixes and
> improvements in this patch series are for this U-Boot specific glue
> code.

Yes, the linux base is very old ... patches are welcome!

And for me it is not that easy, as I do not have a hardware with
current mainline U-Boot running on it... I want to update a hardware
I have to current mainline, but I had no time yet for it...

> I'm no filesystem expert, but after days of debugging I'm quite sure the
> bug is in U-Boot since UBIFS support was added in 2009, and it was
> repeated in 2015 when generic filesystem support for UBIFS was added.
> So please review carefully!

Which bug?

> The crashes were not easily reproducible, only with boards using the old
> distroboot _and_ a boot script inspired by (but not equal to) the one
> proposed by RAUC [1], which basically boils down to:
> 
>    ubifsmount ubi0:boot (from distroboot)
>    test -e (from distroboot)
>    ubifsmount ubi0:rootfs1 (this time from the boot script,
>                             triggering a ubifs_umount)

So, you have a special sequence you execute to trigger the bug, good!

In special 2 ubifsmount in a row... may not often needed for booting!
(I ask me, why that is needed? Boottime is not good than...)

BTW: Is this really a good bootcmd in [1] as on *every* boot your
      Environment is saved? This is not good for lifetime of your
      storage device ... why not using bootcounter?

> Crashes can be triggered more easily, if patch order is changed and
> patch 2 (resetting pointers to NULL after free) comes first, or if patch
> 2 is applied on its own only.

Hmm...

> The fix is in the first patch, and on my boards I see no crashes
> anymore.  I also tested all kinds of combinations of calling `ubi part`,
> `ubi detach`, `ubifsmount`, `ubifsumount`, `ubifsls`, `ubifsload`, `ls`,
> `load`, `size`, and `test -e` and got no crashes anymore after the fix.

That sounds good! Hmm.. test -e has nothing to do with ubi/ubifs I think.

On what hardware do you test? Is it in mainline?

> The three additional patches (2 to 4) are more or less safeguards and
> improvements for the future, and come from me trying and my debugging
> code done on the way, more or less optional, but I think nice to have.

I will look at them .. but give me some time, as I am in holidays the
next 2 weeks ... Hmm.. and it would be good to get some Tested-by
from people with hardware...

bye,
Heiko
> 
> Greets
> Alex
> 
> [1] https://github.com/rauc/rauc/blob/master/contrib/uboot.sh
> 
> Alexander Dahl (4):
>    fs: ubifs: Fix memleak and double free in u-boot wrapper functions
>    fs: ubifs: Set pointers to NULL after free
>    fs: ubifs: Make k(z)alloc/kfree symmetric
>    fs: ubifs: Add volume mounted check
> 
>   fs/ubifs/super.c |  8 ++++++--
>   fs/ubifs/ubifs.c | 31 +++++++++++++++++++------------
>   2 files changed, 25 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 65fbdab27224ee3943a89496b21862db83c34da2
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
