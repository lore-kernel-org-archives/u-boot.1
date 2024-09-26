Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A034CDE025
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 16:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8013488C94;
	Thu, 26 Sep 2024 18:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wmDyYQIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF4788CFC; Thu, 26 Sep 2024 18:45:43 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AF088A9D
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48QGjaE9055900;
 Thu, 26 Sep 2024 11:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727369136;
 bh=HV2PbK25Nj5yw3bPOZJ/cCr1INatqwTTPDF6A79JXWo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=wmDyYQIcvxc9tL7YeQB06mpgBspIBntJ7c3b/rlosUh2jW8eIJKTbaSNUSjJEZEbm
 rm5Vv0IaNmV/gUAwhAbMocwCUdCgeayy0fLnHgmXK3RAwSr+e3N9u1nruDT0zpuPgl
 LufwmKUoOZJemizfFpIdemxjAbRanhNAGwNW+qPs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48QGja78084784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 26 Sep 2024 11:45:36 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 11:45:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 11:45:35 -0500
Received: from [10.249.130.181] ([10.249.130.181])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48QGjUrf101664;
 Thu, 26 Sep 2024 11:45:32 -0500
Message-ID: <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
Date: Thu, 26 Sep 2024 22:15:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: Martin Stolpe <martinstolpe@gmail.com>
CC: "Ivan T. Ivanov" <iivanov@suse.de>, <u-boot@lists.denx.de>, Francois
 Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>, Nikhil M
 Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
 <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 26/09/24 17:56, Martin Stolpe wrote:
> Hi,
> 
> Am Di., 24. Sept. 2024 um 08:38 Uhr schrieb Devarsh Thakkar
> <devarsht@ti.com <mailto:devarsht@ti.com>>:
> 
> 
>     CONFIG_FDT_SIMPLEFB is only used in splash-screen context which in-turn
>     depends on CONFIG_VIDEO. So CONFIG_FDT_SIMPLEFB is in a way dependent on
>     CONFIG_VIDEO. We had fixed similar issue in past in vendor tree and
>     by making
>     CONFIG_FDT_SIMPLEFB dependent on CONFIG_VIDEO using below set of
>     patches [1]
>     which I was planning to post upstream too.
> 
>     Kindly let me know If these patches look good to you and fix your
>     problem too,
>     I can post same set of patches to upstream too.
> 
>     [1] :
>     https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1199800505f11f2162030cb641c6d0c9276d5c9c <https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1199800505f11f2162030cb641c6d0c9276d5c9c>
>     [2] :
>     https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=5b4b8eac243cbd86286ff2cf57ca0469c4d86345 <https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=5b4b8eac243cbd86286ff2cf57ca0469c4d86345>
> 
> 
> These patches look good to me.
> 

Thanks for taking a look, I have posted them to the list [1], it would
be great if you could provide a Reviewed-by or Tested-by too.

> If I understand the code correctly the frame buffer node should only be
> created if CONFIG_FDT_SIMPLEFB is enabled. Thus I would change the code
> like this:
> 

Yes, that's true, I think you also need to conditionally compile
ft_board_setup only when CONFIG_OF_BOARD_SETUP is enabled.

[1]: https://lore.kernel.org/all/20240925151354.480704-4-devarsht@ti.com/

Regards
Devarsh
