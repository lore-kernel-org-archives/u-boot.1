Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE765CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 09:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F588206E;
	Mon, 29 Sep 2025 11:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="JZTrfdc0";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eutXWKHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0550E82A9E; Mon, 29 Sep 2025 11:59:11 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0F0809A5
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 11:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1759139948; x=1790675948;
 h=message-id:date:mime-version:to:cc:references:from:
 in-reply-to:content-transfer-encoding:subject;
 bh=HnKww5maqLvUWuV5p6tksFk9BTgjoIZbTtbRwXJePoU=;
 b=JZTrfdc0FCYMCi051iUXEO4Wj/+eiG41VFNK70zdIeCoOQ00D3TkcRfI
 sB+Q/CePbHxQm0g9aaalXpWqHmnJgqOIzksIzwbSgjxQKWb/tmmWpICPN
 +ZGe84iI+5b2bRT8U5ds7mkaqXRSgr7JaqjNOv+mqPXeAn1UokhA+Y+AV
 uVma+H3pB4kDe8xvDtQo0+KAovuBq+M8LYY1gruSE++UFIDHqr5/CrTfu
 IdTmJczCRT0dYPZGcjQUeY7GrHxznt9XgKfykDn4Xyzsncf/SbmDvaiQQ
 zuLL0srLGp0h1ORGTXwX0g+WkSyqxJZoMGcyG+AdVpmiaTVu4Pf9yulDH g==;
X-CSE-ConnectionGUID: eYz1EVTkS6SyxfjQjmBpaA==
X-CSE-MsgGUID: 0QJBuzl/QD+4W8tvVQ7CmQ==
X-IronPort-AV: E=Sophos;i="6.18,301,1751234400"; d="scan'208";a="46206775"
Subject: Re: Re: [PATCH] bloblist: fix missing OR between licenses in the
 SPDX-License-Identifier
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 29 Sep 2025 11:59:06 +0200
X-CheckPoint: {68DA586A-20-7104F59C-C32877CC}
X-MAIL-CPID: E55E579E2A7D8DE5659CCE9FFF565C70_2
X-Control-Analysis: str=0001.0A2D034F.68DA586B.0062, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF4F1160D1E; Mon, 29 Sep 2025 11:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1759139941;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=HnKww5maqLvUWuV5p6tksFk9BTgjoIZbTtbRwXJePoU=;
 b=eutXWKHU9SgTUzDvQ4b322FFKemafqr3LMzfUGptTiimlyWCD9/qoyzbwIAQqxpEhLHuNt
 VClHRsqwm8b7PMcalpZyJAFfS4FoMvYvkiuYA6PJixxryqdMhm4Jsmq1+OTfKOOmgvpv9B
 9TEx8YXaYMdA//V4t5lO9KupU3455Oo0F6zkaRRvOTbUvmEBE69/zXl53/UkSkESqaMSf3
 G/7QV5Y5Sii7UI/VwLO2zsh5LfGX/9GiKSDCanRqnFovnkgtDXOs+AvoM7TZK+6joN401e
 2jGMzWAk9WkISw8LArayOHOtYBrsm6JXv74hjc129pBwBW0uI2O+CVy4AAUjoQ==
Message-ID: <077e9371-4bd4-4c70-b505-428e8a491d83@ew.tq-group.com>
Date: Mon, 29 Sep 2025 11:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com
References: <20250814120029.234237-1-Max.Merchel@ew.tq-group.com>
 <20250821191232.GA917481@bill-the-cat>
Content-Language: en-US
From: Max Merchel -alt <max.merchel@ew.tq-group.com>
In-Reply-To: <20250821191232.GA917481@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Simon,

Am 21.08.25 um 21:12 schrieb Tom Rini:
> On Thu, Aug 14, 2025 at 02:00:11PM +0200, Max Merchel wrote:
> 
>> Currently, the conditions of both licenses (GPL 2.0 and BSD-3-Clause) must
>> be met. However, the original commit message states that the BSD-3-Clause
>> was added to allow use of the files under a less restrictive license than
>> GPL 2.0. Therefore, the required OR between the licenses has been added.
>>
>> While at it update the SPDX-License-Identifier to SPDX version 3.
>>
>> Fixes: 6c9e3d1f ("bloblist: Relicense to allow BSD-3-Clause")
>> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
>> ---
>>   common/bloblist.c  | 2 +-
>>   include/bloblist.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> So I'm going to defer this as the outcome of
> https://patchwork.ozlabs.org/project/uboot/patch/20250101195817.995321-1-sjg@chromium.org/
> was that it's fine to relicense but a v2 with a differ commit message
> is needed. And while I thought about doing the v2 myself now, I think
> this is something that really must come from the author.
> 
> 

What's your opinion on this?

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

