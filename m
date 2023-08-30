Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017F5C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 15:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D817E863E7;
	Wed, 30 Aug 2023 17:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZbXTbQrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6F0863E7; Wed, 30 Aug 2023 17:17:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C31B8652B
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 17:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UFGtd3066403;
 Wed, 30 Aug 2023 10:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693408615;
 bh=ZjGPPAHE9hwQTRxyN6KqbEzIlpCSU9mBJxbvSF31Yrs=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZbXTbQrmO4yeMGMAvEFsABepJCam0znWS0U9BSMKyV8tGedvc2Qgeot/w/yWiDLk2
 3y62sbReCt9CMLF0hWQ/QToGS8KTBgFiqpeFfbasMBe3rc2ueTFdet8fiQ+lNNyGrx
 tUczgdzq9FErIbkEog2Vi8qMOr9dt01Yto0kre6o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UFGtS5004111
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Aug 2023 10:16:55 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 10:16:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 10:16:55 -0500
Received: from [10.250.38.120] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UFGsjP123155;
 Wed, 30 Aug 2023 10:16:54 -0500
Message-ID: <9fdaef14-2065-155e-6c4d-a505d49995f9@ti.com>
Date: Wed, 30 Aug 2023 10:16:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Jan Kiszka <jan.kiszka@siemens.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>, <u-boot@lists.denx.de>
References: <20230829221457.101469-1-afd@ti.com>
 <20230829221457.101469-3-afd@ti.com>
 <20230830123151.rp7wkhi5m4leg6ny@ravishing>
 <0cbbf080-491f-a0fc-300c-d32cbd06ba70@ti.com>
 <20230830145936.iwl3ew4274adpr4z@litigate>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20230830145936.iwl3ew4274adpr4z@litigate>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 8/30/23 9:59 AM, Nishanth Menon wrote:
> On 09:31-20230830, Andrew Davis wrote:
>> On 8/30/23 7:31 AM, Nishanth Menon wrote:
>>> On 17:14-20230829, Andrew Davis wrote:
>>>> Add am62x_beagleplay_r5_defconfig for R5 SPL and
>>>> am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.
>>>>
>>>> These defconfigs are composite defconfigs built from the config fragment
>>>> board/ti/am62x/beagleplay_*.config applied onto the base
>>>> am62x_evm_*_defconfig.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    configs/am62x_beagleplay_a53_defconfig | 3 +++
>>>>    configs/am62x_beagleplay_r5_defconfig  | 3 +++
>>>>    2 files changed, 6 insertions(+)
>>>>    create mode 100644 configs/am62x_beagleplay_a53_defconfig
>>>>    create mode 100644 configs/am62x_beagleplay_r5_defconfig
>>>>
>>>> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
>>>> new file mode 100644
>>>> index 00000000000..ad708e15397
>>>> --- /dev/null
>>>> +++ b/configs/am62x_beagleplay_a53_defconfig
>>>> @@ -0,0 +1,3 @@
>>>> +// The BeaglePlay defconfig for A53 core
>>>> +#include "configs/am62x_evm_a53_defconfig"
>>>> +#include "board/ti/am62x/beagleplay_a53.config"
>>>> diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
>>>> new file mode 100644
>>>> index 00000000000..276b1f81a3e
>>>> --- /dev/null
>>>> +++ b/configs/am62x_beagleplay_r5_defconfig
>>>> @@ -0,0 +1,3 @@
>>>> +// The BeaglePlay defconfig for R5 core
>>>> +#include "configs/am62x_evm_r5_defconfig"
>>>> +#include "board/ti/am62x/beagleplay_r5.config"
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>> my only complaint is that if we add lets say
>>> board/ti/am62x/dfu.config, Then:
>>>
>>> R5:
>>> 1. am62x_evm_r5_defconfig = am62x_evm_r5_defconfig
>>> 2. am62x_beagleplay_r5_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config
>>> 3. am62x_evm_r5_dfu_defconfig = am62x_evm_r5_defconfig + dfu.config
>>> 4. am62x_beagleplay_r5_dfu_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config + dfu.config
>>>
>>> This information can be in a single txt file Rather than have a
>>> defconfig file for each combination.
>>>
>>
>> Having every combination in a text file vs in a directory of files doesn't
>> seem like much difference to me. `cat combinations.txt` vs `ls -l configs/`.
>> But using a file would mean extra tooling and non-standard usage.
> 
> The .config usage is a standard already in kernel - nothing new there.
> 
> What we are attempting to solve is CI build coverage and test aspect of
> things.
> 

Exactly, when I say "standard" I mean CI standard, which is to take all
the configs/* and build them. No parsing these new combination files needed.
Just add a new configs/xx_defconfig for a combination you want to be
CI tested and you are done.

> Thinking aloud here:
> some sort of board/<vendor>/<board>/ci.conf yaml could probably be a better
> approach with description of build, automated test information,
> potentially board revisions etc.
> 
>> Let's simply try to avoid these combinatorial problems by avoiding adding
>> too many fragments that apply broadly. That adds testing burden. When features
> 
> The combinations will be valid since the intent is a supported
> configuration.
> 

In theory anything you do in menuconfig should result in a valid configuration
(if we have our kconfig symbol dependencies in order). And randomconfig testing
can handle that. The combinations we want always tested should be limited, and
making each have a dedicated configs/ file does that.

Andrew
